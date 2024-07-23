export const validatePassword = (password) => {
    const rules = {
        length: password.length >= 8,
        uppercase: /[A-Z]/.test(password),
        lowercase: /[a-z]/.test(password),
        digit: /\d/.test(password),
        special: /[@$!%*?&]/.test(password),
    };
    return rules;
};