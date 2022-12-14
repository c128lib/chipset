/*
 * Requires KickAssembler v5.x
 * (c) 2022 Raffaele Intorcia
 *
 * References available at
 * https://c128lib.github.io/Reference/Sid
 * https://c128lib.github.io/Reference/D400
 */
#importonce
.filenamespace c128lib

.namespace Sid {
  
.label SID = $D400
.label VOICE1_FREQ_REGISTER_LOW = SID
.label VOICE1_FREQ_REGISTER_HI = SID + 1
.label VOICE1_PULSEWIDTH_LOW = SID + 2
.label VOICE1_PULSEWIDTH_HI = SID + 3
.label VOICE1_CONTROL_REGISTER = SID + 4
.label VOICE1_ATTACK_DECAY = SID + 5
.label VOICE1_SUSTAIN_RELEASE = SID + 6
.label VOICE2_FREQ_REGISTER_LOW = SID + 7
.label VOICE2_FREQ_REGISTER_HI = SID + 8
.label VOICE2_PULSEWIDTH_LOW = SID + 9
.label VOICE2_PULSEWIDTH_HI = SID + 10
.label VOICE2_CONTROL_REGISTER = SID + 11
.label VOICE2_ATTACK_DECAY = SID + 12
.label VOICE2_SUSTAIN_RELEASE = SID + 13
.label VOICE3_FREQ_REGISTER_LOW = SID + 14
.label VOICE3_FREQ_REGISTER_HI = SID + 15
.label VOICE3_PULSEWIDTH_LOW = SID + 16
.label VOICE3_PULSEWIDTH_HI = SID + 17
.label VOICE3_CONTROL_REGISTER = SID + 18
.label VOICE3_ATTACK_DECAY = SID + 19
.label VOICE3_SUSTAIN_RELEASE = SID + 20
.label CUTOFF_FREQ_LOW = SID + 21
.label CUTOFF_FREQ_HI = SID + 22
.label RESONANCE_FILTER_CONTROL_REGISTER = SID + 23
.label VOLUME_FILTER_MODE_REGISTER = SID + 24
.label PADDLE_X_POSITION = SID + 25
.label PADDLE_Y_POSITION = SID + 26
.label VOICE3_OSCILLATOR = SID + 27
.label VOICE3_ENVELOPE = SID + 28

}
