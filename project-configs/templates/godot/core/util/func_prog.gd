class_name FP

extends Object


static func map(fn: Callable, arr: Array) -> Array:
	var result = []
	for i in arr:
		result.append(fn.call(i))
	return result
