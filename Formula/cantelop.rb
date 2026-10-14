# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.15.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.2/cantelop_0.15.2_darwin_amd64.tar.gz"
      sha256 "e93f800557d3d5c1dd09e115ddd0e77e318ca0b2728fd60e2146eb8c8fa0816d"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.2/cantelop_0.15.2_darwin_arm64.tar.gz"
      sha256 "c71741d987aab8aabe29824c60886199b90f81f2e28e6eabb0d9dd8e7b77debf"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.2/cantelop_0.15.2_linux_amd64.tar.gz"
      sha256 "6dfa3ad85f8cfb409655d6507b4de0c0b4e0ce2cf964fad9614632c3f9ab7971"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.2/cantelop_0.15.2_linux_arm64.tar.gz"
      sha256 "ae555496eb20a131b9c27229a83f680b1f2b53ee9cc02d2c9c04ee429955fa3e"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
