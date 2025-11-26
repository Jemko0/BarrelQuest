local Vector = {}
Vector.__index = Vector

-- Constructor: Vector() or Vector(x, y, z)
setmetatable(Vector, {
    __call = function(_, x, y, z)
        return setmetatable({
            x = x or 0,
            y = y or 0,
            z = z or 0
        }, Vector)
    end
})

-- operator

function Vector.__add(a, b)
    return Vector(a.x + b.x, a.y + b.y, a.z + b.z)
end

function Vector.__sub(a, b)
    return Vector(a.x - b.x, a.y - b.y, a.z - b.z)
end

-- Multiplication supports: vector * scalar OR vector * vector
function Vector.__mul(a, b)
    if type(a) == "number" then
        return Vector(a * b.x, a * b.y, a * b.z)
    elseif type(b) == "number" then
        return Vector(a.x * b, a.y * b, a.z * b)
    else
        return Vector(a.x * b.x, a.y * b.y, a.z * b.z)
    end
end

-- Division by scalar
function Vector.__div(a, b)
    return Vector(a.x / b, a.y / b, a.z / b)
end

-- Unary - (negation)
function Vector.__unm(a)
    return Vector(-a.x, -a.y, -a.z)
end

-- Pretty printing
function Vector.__tostring(a)
    return string.format("Vector(%.3f, %.3f, %.3f)", a.x, a.y, a.z)
end

-- self methods

function Vector:length()
    return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

function Vector:normalize()
    local len = self:length()
    if len == 0 then
        return Vector(0, 0, 0)
    end
    return self / len
end

function Vector:dot(b)
    return self.x * b.x + self.y * b.y + self.z * b.z
end

function Vector:cross(b)
    return Vector(
        self.y * b.z - self.z * b.y,
        self.z * b.x - self.x * b.z,
        self.x * b.y - self.y * b.x
    )
end

_G.Vector = Vector

print("RUNNING VECTROR VECTRORVECTRORVECTRORVECTRORVECTRORVECTROR")