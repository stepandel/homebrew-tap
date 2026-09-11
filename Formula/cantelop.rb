# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.0/cantelop_0.8.0_darwin_amd64.tar.gz"
      sha256 "843143f12d656af0a13c2dcc075d8b657bcc0540f83f114c53fa31874095d74b"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.0/cantelop_0.8.0_darwin_arm64.tar.gz"
      sha256 "dd84cbd5626b32803df16660f14d50fcbaece8ffc28d68444d82150024ba39cd"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.0/cantelop_0.8.0_linux_amd64.tar.gz"
      sha256 "265887a905efb81682c708d0428afc8f36359b3eb87549fe0342fbc01b36ecaf"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.0/cantelop_0.8.0_linux_arm64.tar.gz"
      sha256 "1c220856dfc11f4f7809498cb927376b70182c0b6d3d98a504e456988c50a7f5"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
