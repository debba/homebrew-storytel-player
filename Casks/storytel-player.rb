cask "storytel-player" do
  arch arm: "arm64", intel: "e3ceafcc3617971fb714f644622b7053ed3a7ca7b02b1b3cd30c67f848f289ca"

  version "1.3.0"
  sha256 arm:   "5dc01825589148f56fced91aea1ce385a88538d6f209ca6f98791e9e88d7285a",
         intel: "e3ceafcc3617971fb714f644622b7053ed3a7ca7b02b1b3cd30c67f848f289ca"

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
