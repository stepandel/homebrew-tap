# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.9.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.1/cantelop_0.9.1_darwin_amd64.tar.gz"
      sha256 "3a656c3610c95ab2dfd198eb62eea99fe53f10a8b814cb0d140f8e1ed0d9e375"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.1/cantelop_0.9.1_darwin_arm64.tar.gz"
      sha256 "85451c8482b1284ae1f16b51dab29fa0d2dc39187fc245fcd12064000e855cb4"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.1/cantelop_0.9.1_linux_amd64.tar.gz"
      sha256 "1563e07754108575c4adf782e8e48a6ec27d4266bd6fe475f8396e8791b5be5a"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.1/cantelop_0.9.1_linux_arm64.tar.gz"
      sha256 "c4ef533ab053a122487e7c9f35e3fd014a346d7e52809b02922e39de34ba393a"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
