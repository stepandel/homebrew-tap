# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.5.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.1/cantelop_0.5.1_darwin_amd64.tar.gz"
      sha256 "013846ad72ea5ad9e46dc870102a5e4412a829f4354bcddbe5b1cb5bba97a2ce"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.1/cantelop_0.5.1_darwin_arm64.tar.gz"
      sha256 "12e2dacc5b1230f8295c74c26f0379afc7f732bee2c1d11fbb4cd5881f575c6f"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.1/cantelop_0.5.1_linux_amd64.tar.gz"
      sha256 "c62c2b4753ed4db409274a94562e433dc8526e1ff74ae8c81c4416b053a31364"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.5.1/cantelop_0.5.1_linux_arm64.tar.gz"
      sha256 "3b63b2df7704ee336fc20cb7face8d4bd111528b9f8c3e8996001dd358cdbaa7"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
