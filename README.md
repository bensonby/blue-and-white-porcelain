# 青花瓷

## command for creating video

```bash
# create audio file (create score.wav)
timidity --output-24bit -Ow score.midi

# create images (refer to images/ folder)
# crop-images.sh to produce same image size outputs

# create audio with one channel having vocal; the other not
ffmpeg -i score-original-key.wav -i score-original-key-no-vocal.wav -filter_complex "[0:a][1:a]amerge=inputs=2,pan=stereo|c0<c0+c1|c1<c2+c3[aout]" -map "[aout]" result.wav

# fix balance between channels
# Audacity "Amplify" with-vocal track by 6.

# Not Adding reverb, producing little vocal in other track and unwanted noises
# Bathroom, default

# create video
ffmpeg -i result.wav -f concat -i ffmpeg-image-info.txt -ss 0 -t 3:4.842 video.mp4
```
