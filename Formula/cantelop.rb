# typed: false
# frozen_string_literal: true

class Cantelop < Formula
  desc "Deploy complete API and Session runtime releases to Cantelop"
  homepage "https://cantelop.com"
  version "0.8.2"

  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.2/cantelop_0.8.2_darwin_amd64.tar.gz"
      sha256 "392713c344a60bd96c89e5cdb0265e2401ec6cb018266faef2b445273cfb570a"
    end

    if Hardware::CPU.arm?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.2/cantelop_0.8.2_darwin_arm64.tar.gz"
      sha256 "08d9ec45cbda7bef4224ab3b087e8e8ba75c0d8b94fe5dfd33aeae70c9eab4cf"
    end
  end

  on_linux do
    if Hardware::CPU.intel? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.2/cantelop_0.8.2_linux_amd64.tar.gz"
      sha256 "cfa56fc0f1eabcfccb0779f1678c65a78250be3bdf0b5a6cb66f9c8e91609848"
    end

    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/stepandel/homebrew-tap/releases/download/cantelop-v0.8.2/cantelop_0.8.2_linux_arm64.tar.gz"
      sha256 "c9068c2ab6cae4a13fbad9c14e54e46995d95629097ab404417d0667eddd428d"
    end
  end

  def install
    bin.install "cantelop"
  end

  test do
    assert_match "cantelop #{version}", shell_output("#{bin}/cantelop version")
  end
end
