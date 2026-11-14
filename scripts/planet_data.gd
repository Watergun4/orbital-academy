class_name PlanetData
extends RefCounted

# Sizes and distances are in metres for the model, NOT real scale.
# Order and relative size are kept real; the gaps are squashed to fit a room.
# speed = how fast it orbits in the model (inner planets are faster, like real life)

const SUN := {
	"name": "Sun",
	"radius": 0.08,
	"color": Color(1.0, 0.8, 0.2),
	"facts": [
		"The Sun holds about 99.8% of all the mass in the solar system.",
		"Sunlight takes about 8 minutes to reach Earth.",
	],
}

const PLANETS := [
	{
		"name": "Mercury", "type": "Rocky",
		"radius": 0.012, "distance": 0.14, "speed": 0.8,
		"color": Color(0.6, 0.6, 0.6),
		"facts": [
			"Mercury is the smallest planet and the closest to the Sun.",
			"A year on Mercury is only 88 Earth days.",
		],
	},
	{
		"name": "Venus", "type": "Rocky",
		"radius": 0.02, "distance": 0.19, "speed": 0.6,
		"color": Color(0.9, 0.75, 0.45),
		"facts": [
			"Venus is the hottest planet because its thick atmosphere traps heat.",
			"A day on Venus is longer than its year.",
		],
	},
	{
		"name": "Earth", "type": "Rocky",
		"radius": 0.021, "distance": 0.25, "speed": 0.5,
		"color": Color(0.2, 0.45, 0.9),
		"facts": [
			"Earth is the only planet known to have life.",
			"About 71% of Earth's surface is covered in water.",
		],
	},
	{
		"name": "Mars", "type": "Rocky",
		"radius": 0.015, "distance": 0.31, "speed": 0.4,
		"color": Color(0.85, 0.35, 0.2),
		"facts": [
			"Mars looks red because of rusty iron in its soil.",
			"Mars has the tallest volcano in the solar system, Olympus Mons.",
		],
	},
	{
		"name": "Jupiter", "type": "Gas giant",
		"radius": 0.055, "distance": 0.42, "speed": 0.22,
		"color": Color(0.85, 0.7, 0.55),
		"facts": [
			"Jupiter is the biggest planet - more massive than all the others combined.",
			"The Great Red Spot is a storm bigger than Earth.",
		],
	},
	{
		"name": "Saturn", "type": "Gas giant",
		"radius": 0.047, "distance": 0.55, "speed": 0.17, "rings": true,
		"color": Color(0.95, 0.85, 0.6),
		"facts": [
			"Saturn is less dense than water - it would float in a giant bathtub.",
			"Saturn's rings are made of chunks of ice and rock.",
		],
	},
	{
		"name": "Uranus", "type": "Ice giant",
		"radius": 0.032, "distance": 0.66, "speed": 0.12,
		"color": Color(0.6, 0.85, 0.9),
		"facts": [
			"Uranus spins on its side.",
			"Uranus has the coldest atmosphere of any planet.",
		],
	},
	{
		"name": "Neptune", "type": "Ice giant",
		"radius": 0.031, "distance": 0.76, "speed": 0.1,
		"color": Color(0.25, 0.4, 0.9),
		"facts": [
			"Neptune has the fastest winds in the solar system.",
			"Neptune takes about 165 Earth years to go around the Sun once.",
		],
	},
]
