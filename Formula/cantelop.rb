# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and harness releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.1.0-rc.1"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.1/cantelop_0.1.0-rc.1_darwin_amd64.tar.gz"
      sha256 "e3b44dc4e288898b4395ee37321b8cd49f35e5046a8b37168d52a2f3b88a2c73"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.1/cantelop_0.1.0-rc.1_darwin_arm64.tar.gz"
      sha256 "9c54f4d7dfe412484f92ae587e07e594b8fd7950705339dace695050165127e6"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.1/cantelop_0.1.0-rc.1_linux_amd64.tar.gz"
      sha256 "ff287152c15635e1e346db0ad81af438a464fdd7979c7d30f8ae12e53777762c"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.1.0-rc.1/cantelop_0.1.0-rc.1_linux_arm64.tar.gz"
      sha256 "05720ebe701b60b442f85a4bfd2f7a4cdb72ad28859b4f282b9fd99bca242b3f"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
