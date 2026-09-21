# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.9.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.2/cantelop_0.9.2_darwin_amd64.tar.gz"
      sha256 "9969dadb225ccdf95e6539f011d0af6f12ffd31b6c56418488e329dd5f890566"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.2/cantelop_0.9.2_darwin_arm64.tar.gz"
      sha256 "551f544b4b01327385535c528e2e236e2dd5fe26dd6e8c1181ef19eb25743744"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.2/cantelop_0.9.2_linux_amd64.tar.gz"
      sha256 "87de7e81d724a7c665b6d6def80075badac3004ebccb6552bcaaa3d42f3b5424"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.9.2/cantelop_0.9.2_linux_arm64.tar.gz"
      sha256 "4e56014cfd241e27480af04bf7737a97e83c1c783b9669f297d52cba64d127ed"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
