#UseHook
#MaxThreadsPerHotkey 1
#MaxHotkeysPerInterval 9999
#CommentFlag //
Process, priority, , High

//==================
//
// Big Band Skullgirls Script
// by Whale
// v0.2.5
//
//==================

//==================
// "How do I use this?"
// 1. Install AutoHotKey
// 2. Edit this script's buttons (what's LP, MP, etc bound to)
// ... to match yours, somehow. Good luck with that!
// 3. Edit the hotkeys (default: Numpad Keys) if you want to!
// 4. Numpad0, by default, reloads things and stops any ongoing songs.
// 5. Enter new songs at the bottom. Function documentation will guide your way!
//==================

//==================
// Important Links
// 1. AutoHotKey DL: ( https://www.autohotkey.com/download/ahk-install.exe )
// 2. AutoHotKey Key List: ( https://www.autohotkey.com/docs/KeyList.htm )
//==================


//__________________
// CONFIG SECTION -
// Touch as you like!
//__________________

// TODO - Key configs.
// Is this viable in execution time?


//__________________
// STATIC SECTION -
// Probably don't want to touch.
//__________________

// [ DEFAULT GLOBAL VARIABLES ]
// tempo in BPM
global tempo := 120
// precalculated delay between beats in ms
global full_delay := 500
// microsleep to make sure keys register
global micro := 25
//  time in ms before band drops his MP trumpet
global max_wait := 600


//__________________
// SCRIPT SECTION -
// Do >NOT< touch!
//__________________

// [ FUNCTION TO SET TEMPO ]
set_tempo(desired_tempo:=120)
{
	// desired_tempo - in BPM, ie: 120
	global tempo := desired_tempo
	global full_delay := 60000/desired_tempo
	
	Return
}

// [ FUNCTION FOR A MUSICAL BREAK ]
break(beat:=1)
{
	// beat - number of a beat on current tempo, measured in quarter notes, ie: 4 for a whole note.
	
	// sync global variables
	full_delay := global full_delay
	micro := global micro
	
	break_ms(full_delay * beat)
	
	Return
}

// [ FUNCTION FOR A MUSICAL BREAK IN MS ]
break_ms(break_time:=500)
{
	// break_time - in ms
	
	// sync gvar
	micro := global micro
	max_wait := global max_wait
	
	while (break_time > (max_wait + micro) )
	{
		sleep, max_wait
		Send {m down}{. down}
		sleep, micro
		Send {m up}{. up}
		break_time := (break_time - max_wait - micro)
	}

	break_time := Max(break_time,0)
	sleep, break_time
	
	Return
}

// [ FUNCTION TO MANUALLY HOLD OCTAVE ]
// ~ Needed for RAPID MUSIC.
hold_octave(octave:=0)
{
	// octave - a number, zero by default. if it is less than zero, it will play a lower octave. if it is higher, higher. octaves go up on C note.
	if (octave>0)
	{
		Send {w down}
	}
	else if (octave<0)
	{
		Send {s down}
	}
	
	Return
}

// [ FUNCTION TO MANUALLY RELEASE OCTAVE ]
// ~ Needed for RAPID MUSIC.
release_octave(octave:=0)
{
	// octave - a number, zero by default. if it is less than zero, it will play a lower octave. if it is higher, higher. octaves go up on C note.
	if (octave>0)
	{
		Send {w up}
	}
	else if (octave<0)
	{
		Send {s up}
	}
	else if (octave=0)
	{
		Send {w up}{s up}
	}
	
	Return
}

// [ FUNCTION TO PLAY A NOTE ]
play_note(keys, beat:=1, octave:=0)
{

	// keys - a string representing which keys pressed
	// beat - a number, 1 by default. measured in quarter notes, to delay after the note is pressed. 4 is a whole note, 0.5 eigth note, 0.333 triplet note, 0.25 sixteenth
	// octave - a number, zero by default. if it is less than zero, it will play a lower octave. if it is higher, higher. octaves go up on B note.
	
	// start timer to ensure sync
	time_start := A_TickCount
	
	// sync global variables
	full_delay := global full_delay
	micro := global micro
	
	if (octave>0)
	{
		Send {w down}
		sleep, micro
	}
	else if (octave<0)
	{
		Send {s down}
		sleep, micro
	}
	
	if (keys="lp" or keys="F")
	{
		Send {j down}
		sleep, micro
		Send {j up}
	}
	else if (keys="mp" or keys="Gb")
	{
		Send {k down}
		sleep, micro
		Send {k up}
	}
	else if (keys="hp" or keys="C")
	{
		Send {l down}
		sleep, micro
		Send {l up}
	}
	else if (keys="lk" or keys="Bb")
	{
		Send {m down}
		sleep, micro
		Send {m up}
	}
	else if (keys="mk" or keys="B")
	{
		Send {, down}
		sleep, micro
		Send {, up}
	}
	else if (keys="hk" or keys="G")
	{
		Send {. down}
		sleep, micro
		Send {. up}
	}
	else if (keys="lpmp" or keys="E")
	{
		Send {j down}{k down}
		sleep, micro
		Send {j up}{k up}
	}
	else if (keys="lphp" or keys="D")
	{
		Send {j down}{l down}
		sleep, micro
		Send {j up}{l up}
	}
	else if (keys="mphp" or keys="Eb")
	{
		Send {k down}{l down}
		sleep, micro
		Send {k up}{l up}
	}
	else if (keys="lpmphp" or keys="G")
	{
		Send {j down}{k down}{l down}
		sleep, micro
		Send {j up}{k up}{l up}
	}
	if (keys="lkmk" or keys="A")
	{
		Send {m down}{, down}
		sleep, micro
		Send {m up}{, up}
	}
	if (keys="mkhk" or keys="Ab")
	{
		Send {, down}{. down}
		sleep, micro
		Send {, up}{. up}
	}
	
	if (octave>0)
	{
		Send {w up}
	}
	else if (octave<0)
	{
		Send {s up}
	}
	
	time_elapsed := A_TickCount - time_start
	delay := (full_delay * beat) - time_elapsed
	break_ms(delay)
	
	Return
}

NumpadDot::
{
	Reload
	
	Return
}


//__________________
// SONG SECTION -
//__________________

// skullgirls theme new format
Numpad1::
{
	set_tempo(120)
	
	play_note("hp",0.5)
	play_note("mphp",1)
	play_note("lp",0.5)
	play_note("mphp",0.5)
	play_note("lpmphp",1)
	play_note("lk",0.5,-1)
	play_note("hp",0.5)
	play_note("lpmphp",2)
	play_note("hp",1)
	play_note("mkhk",0.5,-1)
	play_note("lp",0.5,-1)
	play_note("mkhk",0.5,-1)
	play_note("lk",0,-1)
	
	Return
}

// darude bandstorm fast
Numpad2::
{
	set_tempo(136)
	
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.5)
	
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.5)
	
	hold_octave(1)
	play_note("E",0.25)
	play_note("E",0.25)
	play_note("E",0.25)
	play_note("E",0.25)
	play_note("E",0.25)
	play_note("E",0.25)
	play_note("E",0.5)
	
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.5)
	release_octave(1)
	
	play_note("A",0.25)
	play_note("A",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.5)
	
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	play_note("B",0.25)
	
	Return
}

// happy bandsday to me
Numpad3::
{
	// normal tempo for this song is
	// 125. doubled to fit within
	// lv.5 super duration.
	set_tempo(250)
	
	play_note("G",0.5)
	play_note("G",0.5)
	play_note("A")
	play_note("G")
	play_note("C",1,1)
	play_note("B",2)
	
	play_note("G",0.5)
	play_note("G",0.5)
	play_note("A")
	play_note("G")
	play_note("D",1,1)
	play_note("C",2,1)
	
	play_note("G",0.5)
	play_note("G",0.5)
	play_note("G",1,1)
	play_note("E",1,1)
	play_note("C",1,1)
	play_note("B")
	play_note("A",1.5)
	
	play_note("F",0.5,1)
	play_note("F",0.5,1)
	play_note("E",1,1)
	play_note("C",1,1)
	play_note("D",1,1)
	play_note("C",2,1)
	
	Return
}

// i bring the skeleton out of the closet
Numpad4::
{
	set_tempo(120)
	
	play_note("D",0.25)
	play_note("D",0.25)
	play_note("D",0.5,1)
	play_note("A",0.5)
	play_note("Ab",0.25)
	break(0.25)
	play_note("G",0.5)
	play_note("F",0.5)
	play_note("D",0.25)
	play_note("F",0.25)
	play_note("G",0.25)
	
	play_note("C",0.25)
	play_note("C",0.25)
	play_note("D",0.5,1)
	play_note("A",0.5)
	play_note("Ab",0.25)
	break(0.25)
	play_note("G",0.5)
	play_note("F",0.5)
	play_note("D",0.25)
	play_note("F",0.25)
	play_note("G",0.25)
	
	play_note("B",0.25,-1)
	play_note("B",0.25,-1)
	play_note("D",0.5,1)
	play_note("A",0.5)
	play_note("Ab",0.5)
	break(0.25)
	play_note("G",0.5)
	play_note("F",0.5)
	play_note("D",0.25)
	play_note("F",0.25)
	play_note("G",0.25)
	
	Return
}

// final victory
Numpad5::
{
	set_tempo(138)
	
	play_note("E",0.25,1)
	play_note("E",0.25,1)
	play_note("E",0.25,1)
	play_note("E",1,1)
	play_note("C",1,1)
	play_note("D",1,1)
	
	play_note("E",0.75,1)
	play_note("D",0.25,1)
	play_note("E",0.5,1)
	
	Return
}

// metal gear solid -- loss music
Numpad6::
{
	// sounds better at this tempo for some reason
	set_tempo(100)
	
	play_note("D",0.5)
	play_note("D",1)
	play_note("Eb",0.5)
	play_note("D",0.4)
	play_note("C",1.2)
	
	play_note("F",0.7)
	play_note("F",0.6)
	play_note("G",0)
	
	Return
}

// when your team comp is first seed in the tournament
Numpad7::
{
	set_tempo(162)
	
	play_note("F")
	play_note("C",0.5,1)
	play_note("B",0.25)
	play_note("C",0.25,1)
	play_note("B",0.25)
	play_note("C",0.25,1)
	play_note("B",0.5)
	play_note("C",0.5,1)
	
	play_note("Ab")
	play_note("F",1.5)
	play_note("F",0.25)
	play_note("Ab",0.25)
	play_note("C",0.25,1)
	
	play_note("D",1,1)
	play_note("A",1)
	play_note("D",1,1)
	play_note("Eb",1,1)
	
	play_note("C",0.5,1)
	play_note("D",0.5,1)
	play_note("C",0.5,1)
	play_note("D",0.5,1)
	play_note("C",1,1)
	play_note("Gb",1,1)
	
	Return
}

// Don't forget a Return at the end of EVERY song!

Return