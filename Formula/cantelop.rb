# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.1/cantelop_0.3.1_darwin_amd64.tar.gz"
      sha256 "6ba22d0f2d211c64b8c83fabb5be166e927cdea25ba3815dec3298a4108a11c7"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.1/cantelop_0.3.1_darwin_arm64.tar.gz"
      sha256 "11346b8051a63032554d53e5b31340144902ca530b1d00dfbc846972f7b2be95"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.1/cantelop_0.3.1_linux_amd64.tar.gz"
      sha256 "861ae0dd712161c4e065d149082eb849c21fa999e7027f544852c1897365d3d4"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.3.1/cantelop_0.3.1_linux_arm64.tar.gz"
      sha256 "5f178bdaff8d8a437f53926e59e1b6ba67d30c9cb76eaef5e512b5b072cfc18d"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
