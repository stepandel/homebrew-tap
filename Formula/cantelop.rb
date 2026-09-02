# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.5.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.0/cantelop_0.5.0_darwin_amd64.tar.gz"
      sha256 "8aa3a4c9c00168c74730c001496a229206a766cbd5de99c84c9eb3ac1043a52f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.0/cantelop_0.5.0_darwin_arm64.tar.gz"
      sha256 "29fd9210d1eb82ba35ebb3c3f42c32fb03087075ea16dc7696caa9fc429ddad6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.0/cantelop_0.5.0_linux_amd64.tar.gz"
      sha256 "454291c2ca0fa6aff4be2ce781f2cbc1284a9d9223a3b5c6170f6e21c49c05e2"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.0/cantelop_0.5.0_linux_arm64.tar.gz"
      sha256 "38fcdeee5838d626e1d0269c9319579d2083eb75001af773a2cc30bdd2212e1e"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
