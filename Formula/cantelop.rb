# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.11.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.1/cantelop_0.11.1_darwin_amd64.tar.gz"
      sha256 "ac1b4ec82afea60b44a889a89621500ab63957dc7ee1272bdd08d18f115d65ea"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.1/cantelop_0.11.1_darwin_arm64.tar.gz"
      sha256 "0ed6d44059d5efc6d9ac76a5c6c72fe19416e5f4cc055d56f7376e04d12a6e8d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.1/cantelop_0.11.1_linux_amd64.tar.gz"
      sha256 "802dfc6d3b83d8eda16f9f845f1b62a1e835fb7de01f73124677078a716b8d69"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.1/cantelop_0.11.1_linux_arm64.tar.gz"
      sha256 "1de860b9deb64164efca1af9833a879c9ac1a449ffbde547eae938e6aa688800"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
