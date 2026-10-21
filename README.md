# Bonsai Image iOS launcher

A one-screen iOS app for the Bonsai Image device lab: on launch it opens `https://seihun.com/bonsai-image-lab/launch` in Safari. That collector route redirects to the current chained benchmark (our page at seihun.com/bonsai-image, then the community WebGPU demo), and both report back to the collector. It exists because BrowserStack App Live sessions start from an app, not a URL.

`bash build.sh` on a Mac with Xcode builds `build/BonsaiImageLauncher.ipa`; the workflow builds it on every push to main. Measurements and method: `projects/renia/engineering/campaigns/bonsai/bonsai-image` on kenan-server.
