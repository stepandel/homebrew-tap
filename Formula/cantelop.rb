# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.10.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.10.0/cantelop_0.10.0_darwin_amd64.tar.gz"
      sha256 "016a76852dd915377323efb3707f0f72432a3b7c374034f38ceb83b612be5936"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.10.0/cantelop_0.10.0_darwin_arm64.tar.gz"
      sha256 "d05af7f36ee78773ae012d53304fb40d58fe82d1fb6c3f0e268324ac2b64766d"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.10.0/cantelop_0.10.0_linux_amd64.tar.gz"
      sha256 "c21c4b8921f4aa94588fba6d1ec92314ef7e0a21e4669b3c20e7f4cd37db83dd"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.10.0/cantelop_0.10.0_linux_arm64.tar.gz"
      sha256 "eead7734e4991cd4c76a09e3d9be2e9ebdbee6d769d36d243ae1332a7ceec235"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
