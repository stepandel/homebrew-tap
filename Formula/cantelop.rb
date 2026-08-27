# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.1/cantelop_0.2.1_darwin_amd64.tar.gz"
      sha256 "d3163c7b05c6ea1ac9cc53c872294df08083345ac879a4632ff19280ab25c117"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.1/cantelop_0.2.1_darwin_arm64.tar.gz"
      sha256 "1a16417c2282b1e7c4863e61d2ebaf5fe09b6e4f81272057ba0d4301c986c2a7"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.1/cantelop_0.2.1_linux_amd64.tar.gz"
      sha256 "854c23ac136d72ff0c3038ee02e47f895ef88f7d99902b5737c5ea36a852efff"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.2.1/cantelop_0.2.1_linux_arm64.tar.gz"
      sha256 "0d857960f14293bec15c3d707db29f9d52ed46dad887a3bef12f105e20752943"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
