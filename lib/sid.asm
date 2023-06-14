/**
  @file sid.asm
  @brief Sid module

  @copyright MIT Licensed
  @date 2022
*/

#importonce
.filenamespace c128lib

.namespace Sid {
  
/** Sid main address */
.label SID = $D400
/** Frequency register for voice 1 (low byte) */
.label VOICE1_FREQ_REGISTER_LOW = SID
/** Frequency register for voice 1 (high byte) */
.label VOICE1_FREQ_REGISTER_HI = SID + 1
/** Pulsewidth for voice 1 (low byte)  */
.label VOICE1_PULSEWIDTH_LOW = SID + 2
/** Pulsewidth for voice 1 (high byte) */
.label VOICE1_PULSEWIDTH_HI = SID + 3
/** Control register for voice 1 */
.label VOICE1_CONTROL_REGISTER = SID + 4
/** Attack/decay register for voice 1 */
.label VOICE1_ATTACK_DECAY = SID + 5
/** Sustain/release register for voice 1 */
.label VOICE1_SUSTAIN_RELEASE = SID + 6
/** Frequency register for voice 2 (low byte) */
.label VOICE2_FREQ_REGISTER_LOW = SID + 7
/** Frequency register for voice 2 (high byte) */
.label VOICE2_FREQ_REGISTER_HI = SID + 8
/** Pulsewidth for voice 2 (low byte) */
.label VOICE2_PULSEWIDTH_LOW = SID + 9
/** Pulsewidth for voice 2 (high byte) */
.label VOICE2_PULSEWIDTH_HI = SID + 10
/** Control register for voice 2 */
.label VOICE2_CONTROL_REGISTER = SID + 11
/** Attack/decay register for voice 2 */
.label VOICE2_ATTACK_DECAY = SID + 12
/** Sustain/release register for voice 2 */
.label VOICE2_SUSTAIN_RELEASE = SID + 13
/** Frequency register for voice 3 (low byte) */
.label VOICE3_FREQ_REGISTER_LOW = SID + 14
/** Frequency register for voice 3 (high byte) */
.label VOICE3_FREQ_REGISTER_HI = SID + 15
/** Pulsewidth for voice 3 (low byte)  */
.label VOICE3_PULSEWIDTH_LOW = SID + 16
/** Pulsewidth for voice 3 (high byte) */
.label VOICE3_PULSEWIDTH_HI = SID + 17
/** Control register for voice 3 */
.label VOICE3_CONTROL_REGISTER = SID + 18
/** Attack/decay register for voice 3 */
.label VOICE3_ATTACK_DECAY = SID + 19
/** Sustain/release register for voice 3 */
.label VOICE3_SUSTAIN_RELEASE = SID + 20
/** Filter cutoff frequency (low byte) */
.label CUTOFF_FREQ_LOW = SID + 21
/** Filter cutoff frequency (high byte) */
.label CUTOFF_FREQ_HI = SID + 22
/** Resonance/filter control register */
.label RESONANCE_FILTER_CONTROL_REGISTER = SID + 23
/** Volume/filter mode register */
.label VOLUME_FILTER_MODE_REGISTER = SID + 24
/** Potentiometer (paddle) x position */
.label PADDLE_X_POSITION = SID + 25
/** Potentiometer (paddle) y position */
.label PADDLE_Y_POSITION = SID + 26
/** Voice 3 oscillator output */
.label VOICE3_OSCILLATOR = SID + 27
/** Voice 3 envelope generator output */
.label VOICE3_ENVELOPE = SID + 28

}
