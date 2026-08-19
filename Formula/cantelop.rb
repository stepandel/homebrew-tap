# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0/cantelop_0.1.0_darwin_amd64.tar.gz"
      sha256 "48a51bd7e38f0cb7441d50901195af5a60e40cb18f20d440f371cc5fb7e0cd05"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0/cantelop_0.1.0_darwin_arm64.tar.gz"
      sha256 "602f0c3914c0c7bf481dada34a303ccd2d651bd4660b5dd714c07f0e4353081d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0/cantelop_0.1.0_linux_amd64.tar.gz"
      sha256 "3e97f44c676bd14dd413f41fca7eb9d3a72f72d1618fa798936af20569a0eba0"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0/cantelop_0.1.0_linux_arm64.tar.gz"
      sha256 "d3f1d0ad361ad1144d1622784b7f0aa7ef3887dc462d1a03c81b469c67880228"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
