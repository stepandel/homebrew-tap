# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.12.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.12.0/cantelop_0.12.0_darwin_amd64.tar.gz"
      sha256 "3c0c72deab8579d4c253eff627b55e9d1160eb2f88f3c1e2fa6b1c2e82f8b678"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.12.0/cantelop_0.12.0_darwin_arm64.tar.gz"
      sha256 "91566095c121f2fc9ff0b543130046ea492204f68f3945d04dede76892aed090"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.12.0/cantelop_0.12.0_linux_amd64.tar.gz"
      sha256 "7c9347d485c532d6e37666ccc089d382c67e9aec53885019ad8b75ee8dab24dc"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.12.0/cantelop_0.12.0_linux_arm64.tar.gz"
      sha256 "ae454a23397c6dd361d7edbf6a52390616e8b3059a26af31dd388bf7f1d94395"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
