# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.11.0"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.0/cantelop_0.11.0_darwin_amd64.tar.gz"
      sha256 "c173924ff412dcd72f434559e1e9dec8ae44c99de6dc83df6c9dc64c1aae585f"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.0/cantelop_0.11.0_darwin_arm64.tar.gz"
      sha256 "a7f2a22b2a53635a1358882144f1246af455a5523e766509f3d986ba24873691"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.0/cantelop_0.11.0_linux_amd64.tar.gz"
      sha256 "d871186956c245d54f08f443024ba600cb085f56b05a8c5942433e390410c579"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.11.0/cantelop_0.11.0_linux_arm64.tar.gz"
      sha256 "73ecd4660643b9dd9c93e80c7b548b2aa97c97a7f25b7a8a0f2a3bc904f8b5f4"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
