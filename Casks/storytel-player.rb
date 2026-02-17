cask "storytel-player" do
  version "1.2.7"
  sha256 "b250860d9dadf8183a77e84f1f4055fe73745d7a7d626fae8bc646b032a97117"

  url "https://github.com/debba/storytel-player/releases/download/v#{version}/Storytel-Player-#{version}.dmg"
  name "Storytel Player"
  desc "Unofficial Storytel Player for Desktop"
  homepage "https://github.com/debba/storytel-player"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true
  depends_on macos: ">= :monterey"

  app "Storytel Player.app"
  
  postflight do
  system_command "xattr",
                  args: [
                      "-c", "#{appdir}/Storytel Player.app"
                  ]
  end

  zap trash: [
    "~/Library/Application Support/storytel-player",
    "~/Library/Caches/storytel-player",
    "~/Library/Logs/storytel-player",
    "~/Library/Preferences/com.debba.storytel-player.plist",
    "~/Library/Saved Application State/com.debba.storytel-player.savedState",
  ]
end
