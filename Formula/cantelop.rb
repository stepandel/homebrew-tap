# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.13.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.1/cantelop_0.13.1_darwin_amd64.tar.gz"
      sha256 "b17a45ddc9fc7ec1db9ab8db4cc058db4e1921956e20e202a3f73825c08fa419"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.1/cantelop_0.13.1_darwin_arm64.tar.gz"
      sha256 "a18101e0eda4e0888d9d3d50ab0d9c32922b898270f6e33d4dea49173e32e532"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.1/cantelop_0.13.1_linux_amd64.tar.gz"
      sha256 "de15dedd7f5367dd6eea347c20ded8ce36dca177cedc901c0eb740be223ff350"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.1/cantelop_0.13.1_linux_arm64.tar.gz"
      sha256 "20aceed77c1d4d8ea7eae958227a17e47600d7ba5ce42d55d532b1aaca757b6f"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
