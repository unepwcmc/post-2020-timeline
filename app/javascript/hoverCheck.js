// add a class to the body if hover is available

const canHover = !(matchMedia('(hover: none)').matches)

if(canHover) {
	document.body.classList.add('can-hover')
}