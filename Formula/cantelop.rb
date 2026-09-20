# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.8.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.3/cantelop_0.8.3_darwin_amd64.tar.gz"
      sha256 "ec2b56b9f72a8c28f382766412e86bc0da38be4a22fc21b5bcf22d9601fa0843"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.3/cantelop_0.8.3_darwin_arm64.tar.gz"
      sha256 "1dad67c1425cf7c2d1f8f397897814fbf0890a3121b07ab115e9d3c1005477f8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.3/cantelop_0.8.3_linux_amd64.tar.gz"
      sha256 "a37df6756907ac26037640dd4eee24ca171a06c4507a541c16ed5f483889840d"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.3/cantelop_0.8.3_linux_arm64.tar.gz"
      sha256 "1ae4c84e4a6a3e4c26af97d153ef8ee7f7e62ebd9f858fb1c2924505cccbae2c"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
