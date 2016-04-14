require "language/go"

class DockerSwarm < Formula
  desc "Turn a pool of Docker hosts into a single, virtual host"
  homepage "https://github.com/docker/swarm"
  url "https://github.com/docker/swarm/archive/v1.2.0.tar.gz"
  sha256 "8a30745ef4129a848dd2e88fc511c9eb85af07fbdbb46645f2e860b2aacdf8e6"
  head "https://github.com/docker/swarm.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "1b2a683c7a81c6f4ac07489acaa208761e334db216a1aefbda31ed226973cbfe" => :el_capitan
    sha256 "ee895056f283b9988cc06453493a69c5887fb6044492531901f7dfcb0f69b2e3" => :yosemite
    sha256 "a97d21fe7435235a2f0c6a1badf4851ba73b920144d896cd8dbbde4c6a3ac961" => :mavericks
  end

  depends_on "go" => :build

  def install
    mkdir_p buildpath/"src/github.com/docker"
    ln_s buildpath, buildpath/"src/github.com/docker/swarm"
    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"
    system "go", "build", "-o", "docker-swarm"
    bin.install "docker-swarm"
  end

  test do
    output = shell_output(bin/"docker-swarm --version")
    assert_match "swarm version #{version} (HEAD)", output
  end
end
