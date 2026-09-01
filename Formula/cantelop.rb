# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.3.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.3/cantelop_0.3.3_darwin_amd64.tar.gz"
      sha256 "dc6fa3efb2dccb4970de7b7b75c88f54eb989e7fbed29d5eeb5b63b2ba0bbd0a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.3/cantelop_0.3.3_darwin_arm64.tar.gz"
      sha256 "3a903b77e636dec93393e8d699af69b85eea4e67c660f08edb3b8fd801033461"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.3/cantelop_0.3.3_linux_amd64.tar.gz"
      sha256 "76f3838dbc3b4f2cd65cb9b1f60f8e32023fe16c054a2927e9a22d22a228c187"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.3/cantelop_0.3.3_linux_arm64.tar.gz"
      sha256 "a6a659b78dd17ae78931b212d20d18ed85b03fe35c18aed51bd6c57b5ccfde0f"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
