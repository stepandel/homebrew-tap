# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.15.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.1/cantelop_0.15.1_darwin_amd64.tar.gz"
      sha256 "2da4ddd4f746c59ab07c3274405b37cbe89b26f4bdd3a4adb12af806b06d4f6a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.1/cantelop_0.15.1_darwin_arm64.tar.gz"
      sha256 "c3e3aa9f47ae386e6d8115eb2a566160a9751b866e3a850a058a5356d78f28fc"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.1/cantelop_0.15.1_linux_amd64.tar.gz"
      sha256 "fbe515f8a456b5293a551257d4a837e55c6784ad9af8cd2be89a92a9d5cec715"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.15.1/cantelop_0.15.1_linux_arm64.tar.gz"
      sha256 "d6200ff3b0327aa81cc543a3947fa635beb7ad1b15f992d8ccd8cfce7b5eb8f2"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
