---
name: david-huck-video-editing
description: David Huck's short-form video editing workflow and house style. Use whenever David (Huck) shares a selfie/talking-head video or Drive link and wants it edited with cuts, captions, motion graphics, sound design and audio balancing for TikTok, Reels, LinkedIn, Facebook and Shorts. Always read style-log.md first and append feedback to it after every edit.
---

# David Huck video editing

Owner: David Huck. Output goes to all short-form platforms (TikTok, Reels, LinkedIn, Facebook, Shorts), so one master file must work everywhere.

## Before every edit
1. Read `style-log.md` in this folder. It is the learned record of what David likes and dislikes. It overrides the defaults below.
2. Confirm the tools are present: `ffmpeg`, `ffprobe`, and the HyperFrames skills (`.claude/skills/hyperframes*`, `talking-head-recut`, `embedded-captions`, `motion-graphics`). If missing, run `.claude/hooks/install-video-skills.sh`.
3. Never claim to have judged delivery, energy or taste by eye. Work from transcript, sampled frames and measurements. Say so, and ask David to review.

## Ingest
- Source is a Google Drive file shared as "anyone with the link". Fetch with curl from `drive.usercontent.google.com` (needs the host on the environment's allowed domains).
- The Drive connector's `download_file_content` returns base64 into context. Do NOT use it for video.
- If the network blocks Drive, stop and tell David which host to allow. Do not mock results.
- Run `ffprobe` first and report resolution, fps, duration, audio layout.

## Output spec (master)
- 1080x1920, 9:16, 30 fps (keep 60 only if the source is 60 and motion graphics benefit), H.264 High, yuv420p, AAC 48 kHz, `-movflags +faststart`.
- If the source is horizontal, crop/reframe on the face and flag the resolution loss.
- Keep key text inside the safe zone: roughly 150 px from the top, 300 px from the bottom, 90 px from each side, so platform UI never covers it.
- Burned-in captions on by default.

## Brand
- Minimalist black and white base. Accent colors: red for emphasis, warnings, negatives; green for wins, positives, confirmations. Max two accents per video, used consistently with those meanings.
- Clean sans-serif type, high contrast, generous spacing. Exact font/logo: ask David once, then record it in `style-log.md`.

## Motion graphics
- David wants an ambitious, dense look: icons, shading, depth, kinetic type, sound-synced hits. It must look like what working creators actually use, not templates or cartoon stickers.
- Rules: every graphic is tied to a spoken word or beat; nothing covers the face for long; no more than one major element on screen competing with captions; consistent easing across the video.
- Density dial: `light`, `standard`, `max`. Default `standard`. Do `max` when asked and say what you removed or kept so David can tune it.

## Sound
- Use only sounds David has rights to, or synthesized with ffmpeg (whoosh, pop, click, impact, riser). Never pull copyrighted music or samples.
- Sound effects sit well below the voice; duck music/SFX under speech.

## Audio balance (measure, don't guess)
- Normalize the mix to about -14 LUFS integrated, true peak <= -1.5 dBTP (`ffmpeg ... -af loudnorm`, two-pass, or `ebur128`).
- Report measured LUFS and peak before and after. Flag clipping, noise, or SFX that peak above the voice.

## Fact-check
- Extract every factual claim from the transcript. Verify each with web search. List: claim, verdict, source. Mark anything unverifiable. Never silently change what David said; propose a fix and ask.

## QA before delivering
- Re-run `ffprobe` on the output; confirm spec. Extract frames at the start, middle and end plus every graphic hit and look for overlap, clipping and unsafe-zone text.
- Report what was done, what could not be verified, and the render time.

## Delivery
- Don't send large video through the Drive connector (base64). Push renders to a dedicated `renders` branch or release rather than `main` to avoid bloating history, and give David the link. Cap at 100 MB per file on GitHub.

## Feedback loop
After each edit ask David what to keep and what to change. Append dated, specific entries to `style-log.md` (likes, dislikes, parameters like timings and sizes). Promote repeated preferences into the sections above.
