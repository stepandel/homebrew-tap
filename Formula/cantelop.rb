# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.17.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.2/cantelop_0.17.2_darwin_amd64.tar.gz"
      sha256 "879519b1a2414020bd6fb46afc5fe25568434530407ff990ae2bb2a44cbbf859"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.2/cantelop_0.17.2_darwin_arm64.tar.gz"
      sha256 "e7e24a57177a60d2be937c4133bb6aa08cfcb40761a7784a0d215e1b2ebe6d3c"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.2/cantelop_0.17.2_linux_amd64.tar.gz"
      sha256 "cd9f195ccfe575770b59b5741b65e5b0cbd035015f07b3d27d74e59a3d091376"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.17.2/cantelop_0.17.2_linux_arm64.tar.gz"
      sha256 "50cd2c6a08b3d83ca52ed4173d1679aa02df556e6e8935811a42b9652c552fbb"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
