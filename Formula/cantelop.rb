# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.16.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.1/cantelop_0.16.1_darwin_amd64.tar.gz"
      sha256 "f0d9a7ea33cf1a43067760d2c349bf1ed6f672c984f498738c337ea17700781f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.1/cantelop_0.16.1_darwin_arm64.tar.gz"
      sha256 "87363d589d1629bdb753cd752b8120904a692518decde38c1d251232e57d58cd"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.1/cantelop_0.16.1_linux_amd64.tar.gz"
      sha256 "f6a4812d6cf9f697b584559be8f60f9812261e1302bec3037c688d7d3cb5a041"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.16.1/cantelop_0.16.1_linux_arm64.tar.gz"
      sha256 "0658ecd4db125768b15987fcfc83c3776f0d7c68e087df2a09a5494713c8936c"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
