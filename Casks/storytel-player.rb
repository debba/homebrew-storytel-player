cask "storytel-player" do
  arch arm: "arm64", intel: "2df89c144050f7215360812ffd637b77a1ce6374548e108f082e8f57ac7d925c"

  version "1.2.15"
  sha256 arm:   "38bbc2f0e98877ddea00469d945a337e9bfd6624af3c4738adb91d056fee042e",
         intel: "2df89c144050f7215360812ffd637b77a1ce6374548e108f082e8f57ac7d925c"

  url "https://github.com/debba/storytel-player/releases/download/v#{version}/Storytel-Player-#{version}-mac-#{arch}.dmg"
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
