class Chunder < Formula
  desc "Download, search, clip, and even WATCH YouTube videos in your terminal"
  homepage "https://github.com/chunder-cli/chunder"
  url "https://github.com/chunder-cli/chunder/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "bdf44bb3edc5cfdc576939a9dc0804ebbadbcc6814f065412712e0a6d341090f"
  license "MIT"
  head "https://github.com/chunder-cli/chunder.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = %W[
      -s -w
      -X github.com/chunder-cli/chunder/cmd.version=v#{version}
      -X github.com/chunder-cli/chunder/cmd.commit=homebrew
    ].join(" ")
    system "go", "build", *std_go_args(ldflags: ldflags)

    generate_completions_from_executable(bin/"chunder", "completion")
  end

  def caveats
    <<~EOS
      ffmpeg unlocks 1080p+ downloads, clips, mp3 conversion, subtitle
      embedding, and `chunder watch`:
        brew install ffmpeg
    EOS
  end

  test do
    assert_match "chunder v#{version}", shell_output("#{bin}/chunder version")
  end
end
