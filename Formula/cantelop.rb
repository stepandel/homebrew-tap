# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.4.0/cantelop_0.4.0_darwin_amd64.tar.gz"
      sha256 "52cce597724ea1545718aede47ab5df9d251eae8a00547426bda0783d409cf0f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.4.0/cantelop_0.4.0_darwin_arm64.tar.gz"
      sha256 "f634c10735ee13b92adf3c2d2f937a35bd1adf9e85a79f5adf1b3c5136a60b98"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.4.0/cantelop_0.4.0_linux_amd64.tar.gz"
      sha256 "6d7cbad521cb8e1001f50a28334b82dd6aaed629a00bc9ef96fe9085924a0df9"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.4.0/cantelop_0.4.0_linux_arm64.tar.gz"
      sha256 "92c8fe45c8c0157ea0e043ad602d814488cd2a2c850eec6639b67a261fb463c6"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
