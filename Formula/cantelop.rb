# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.11.3"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.3/cantelop_0.11.3_darwin_amd64.tar.gz"
      sha256 "6c1f2c8a11d694da384c11471552bc542890bd655f79f611753fe70bf42e8ab5"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.3/cantelop_0.11.3_darwin_arm64.tar.gz"
      sha256 "20713b767d94ccabfd22133ca6d53e89d914f2ecb839ad0d874b36ea16324ec8"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.3/cantelop_0.11.3_linux_amd64.tar.gz"
      sha256 "35436d7827d9d85e52a3d2a13a0a566142569704782304960be9d3af8cc5793a"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.3/cantelop_0.11.3_linux_arm64.tar.gz"
      sha256 "b971600b80ac04a81f7e39e33bb637d03e6d060c3d5f287adb1302c0e00eecb7"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
