class NowplayingWidget < Formula
  desc "Always-on-top floating widget showing Apple Music's current track and artwork"
  homepage "https://github.com/uuuhyun/nowplaying-widget"
  url "https://github.com/uuuhyun/nowplaying-widget/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "3144f1b6f24e075f4bd21474fa4fd864db136f828e1aa42ab9954ac646aa3b4a"
  license "MIT"

  depends_on macos: :sonoma

  def install
    system "bash", "scripts/build-app.sh", buildpath/"build"
    prefix.install "build/NowPlaying.app"
  end

  service do
    run [opt_prefix/"NowPlaying.app/Contents/MacOS/NowPlaying"]
    keep_alive crashed: true
    process_type :interactive
  end

  def caveats
    <<~EOS
      로그인 시 자동 실행 / Start now and at login:
        brew services start nowplaying-widget

      Music 앱이 켜져 있을 때만 위젯이 보입니다. 처음 한 번 'Music 제어' 권한을 허용해 주세요.
      The widget shows while Music is running. Allow the Music automation prompt once.
    EOS
  end

  test do
    assert_predicate prefix/"NowPlaying.app/Contents/MacOS/NowPlaying", :executable?
  end
end
