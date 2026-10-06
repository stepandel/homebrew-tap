# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.13.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.0/cantelop_0.13.0_darwin_amd64.tar.gz"
      sha256 "7fd56aa6985be8af7572bf5e39c11bac8517198a25754b2ba01d289518e88270"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.0/cantelop_0.13.0_darwin_arm64.tar.gz"
      sha256 "e50af304af989cabe4797475963b7fa204c0b0fae181b6079d97944993f5191b"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.0/cantelop_0.13.0_linux_amd64.tar.gz"
      sha256 "06412c7c35ac0c23b678ccc445a7ed7a29a8346ac78ba402b14dcde1fc96894e"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.13.0/cantelop_0.13.0_linux_arm64.tar.gz"
      sha256 "4cc8e4741ced5aeb18c3ff4f3dab37d0f7aa2f1903ecfffc7a6e1a3750d42f9b"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
