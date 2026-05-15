cask "storytel-player" do
  arch arm: "arm64", intel: "x64"

  version "1.2.13"
  sha256 arm:   "72d84790e701cd8e99cc39c32770b5f367b2a7ff0f014bbc4f4f69b17af807e7",
         intel: "a978e23299fdf9da2e7e58666349c163fe519e3a3e8229b66b3073c13561c04d"

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
