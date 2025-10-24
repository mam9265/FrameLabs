module.exports = (allowedRoles) => (req, res, next) => {
    const userRole = req.user.role;

    if(!allowedRoles.includes(userRole)) {
        return res.status(403).send('Forbidden: Insufficent Privileges.');
    }
    next();
}