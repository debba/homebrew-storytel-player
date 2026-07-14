cask "storytel-player" do
  arch arm: "arm64", intel: "cdd87e336ad238c7b7436686d3f2ef4c9384607529d6a110bdb35b4bb88c3fed"

  version "1.2.16"
  sha256 arm:   "354b23871d9eeb6407071a1ff7bfdbfd22cafd5a3ec24eed9e633b5c8fd2351b",
         intel: "cdd87e336ad238c7b7436686d3f2ef4c9384607529d6a110bdb35b4bb88c3fed"

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
