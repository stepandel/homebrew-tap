# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.16.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.0/cantelop_0.16.0_darwin_amd64.tar.gz"
      sha256 "6de5c2b59a109e418c384c9d60960405f7033aa1ddee66b1066e03ad3b3010b1"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.0/cantelop_0.16.0_darwin_arm64.tar.gz"
      sha256 "c08a884b2ece8e0efc81769f3bfb64bfea6ae962f218d2a31aaa818ce28ca908"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.0/cantelop_0.16.0_linux_amd64.tar.gz"
      sha256 "0484d52d4816c1d256ed58d4ffbc1fcc943a2075c63957a8cf23c940bda180da"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.0/cantelop_0.16.0_linux_arm64.tar.gz"
      sha256 "542405bf3dbc62a4b97165697bba22a3e4a402869a532aea6fbfca76fe14d34c"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
