import React, { useState } from 'react';
import { validatePassword } from './passwordValidation'; // Make sure this file is in the same directory

function Signup() {
    var username;
    var signupEmail;
    var signupPassword;
    var firstName;
    var lastName;

    const [message, setMessage] = useState('');
    const [passwordError, setPasswordError] = useState('');
    const [passwordRules, setPasswordRules] = useState({
        length: false,
        uppercase: false,
        lowercase: false,
        digit: false,
        special: false,
    });

    function buildPath(route) {
        if (process.env.NODE_ENV === 'production') {
            return 'https://www.thisisforourclass.xyz/' + route;
        } else {
            return 'http://localhost:5000/' + route;
        }
    }

    const doSignup = async event => {
        event.preventDefault();

        const password = signupPassword.value;

        if (!Object.values(passwordRules).every(rule => rule)) {
            setPasswordError('Password must meet all the requirements.');
            return;
        }

        var obj = {
            username: username.value,
            password: password,
            firstName: firstName.value,
            lastName: lastName.value,
            email: signupEmail.value
        };
        var js = JSON.stringify(obj);

        try {
            const response = await fetch(buildPath("api/signup"), {
                method: 'POST',
                body: js,
                headers: { 'Content-Type': 'application/json' },
            });

            const res = await response.json();

            if (!response.ok) {
                setMessage(res.message || 'An error occurred during signup.');
            } else {
                var user = { firstName: res.firstName, lastName: res.lastName, id: res.id };
                localStorage.setItem('user_data', JSON.stringify(user));
                setMessage('');
                window.location.href = '/Home';
            }
        } catch (e) {
            setMessage('An error occurred during signup.');
            console.error(e);
        }
    };

    const handlePasswordChange = (e) => {
        const password = e.target.value;
        signupPassword = e.target;
        const rules = validatePassword(password);
        setPasswordRules(rules);
        setPasswordError(Object.values(rules).every(rule => rule) ? '' : 'Password must meet all the requirements.');
    };

    return (
        <div className="bg-white-800 border-1 border-solid border-red-800 justify-items-center">
            <div className="bg-white shadow-2xl h-auto w-[352px] border border-solid rounded mt-20 mx-auto px-5 py-10">
                <form className="space-y-6 border-0 border-solid border-indigo-600" action="#" method="POST" onSubmit={doSignup}>
                    <div className="border-0 border-solid border-indigo-600 sm:mx-auto sm:w-full sm:max-w-sm">
                        <h2 className="mt-9 mb-8 text-center text-4xl font-semibold leading-9 tracking-tight text-gray-900">
                            Create your account
                        </h2>
                    </div>
                    <div>
                        <label htmlFor="username" className="block text-md font-medium leading-6 text-gray-900">
                            Username
                        </label>
                        <div className="mt-2">
                            <input
                                id="username"
                                name="username"
                                type="text"
                                autoComplete="username"
                                required
                                className="block w-full rounded-md border-0 py-3
                                    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                                ref={(c) => username = c}
                            />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="firstName" className="block text-md font-medium leading-6 text-gray-900">
                            First Name
                        </label>
                        <div className="mt-2">
                            <input
                                id="firstName"
                                name="firstName"
                                type="text"
                                autoComplete="given-name"
                                required
                                className="block w-full rounded-md border-0 py-3
                                    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                                ref={(c) => firstName = c}
                            />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="lastName" className="block text-md font-medium leading-6 text-gray-900">
                            Last Name
                        </label>
                        <div className="mt-2">
                            <input
                                id="lastName"
                                name="lastName"
                                type="text"
                                autoComplete="family-name"
                                required
                                className="block w-full rounded-md border-0 py-3
                                    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                                ref={(c) => lastName = c}
                            />
                        </div>
                    </div>
                    <div>
                        <label htmlFor="email" className="block text-md font-medium leading-6 text-gray-900">
                            Email address
                        </label>
                        <div className="mt-2">
                            <input
                                id="email"
                                name="email"
                                type="email"
                                autoComplete="email"
                                required
                                className="block w-full rounded-md border-0 py-3
                                    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                                ref={(c) => signupEmail = c}
                            />
                        </div>
                    </div>
                    <div>
                        <div className="flex items-center justify-between">
                            <label htmlFor="password" className="block text-md font-medium leading-6 text-gray-900">
                                Password
                            </label>
                        </div>
                        <div className="mt-2">
                            <input
                                id="password"
                                name="password"
                                type="password"
                                autoComplete="new-password"
                                required
                                className="block w-full rounded-md border-0 py-3
                                    text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                                ref={(c) => signupPassword = c}
                                onChange={handlePasswordChange}
                            />
                        </div>
                        {passwordError && <p className="text-red-500 text-xs italic">{passwordError}</p>}
                        <p className="text-xs text-gray-500 mt-1">
                            Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one digit, and one special character.
                        </p>
                        <ul className="list-disc pl-5 mt-2 text-sm text-gray-600">
                            <li className={passwordRules.length ? 'text-green-500' : 'text-red-500'}>
                                At least 8 characters
                            </li>
                            <li className={passwordRules.uppercase ? 'text-green-500' : 'text-red-500'}>
                                At least one uppercase letter
                            </li>
                            <li className={passwordRules.lowercase ? 'text-green-500' : 'text-red-500'}>
                                At least one lowercase letter
                            </li>
                            <li className={passwordRules.digit ? 'text-green-500' : 'text-red-500'}>
                                At least one digit
                            </li>
                            <li className={passwordRules.special ? 'text-green-500' : 'text-red-500'}>
                                At least one special character (@, $, !, %, *, ?, &)
                            </li>
                        </ul>
                    </div>
                    <div className="py-6">
                        <button
                            type="submit"
                            className="flex w-full justify-center rounded-md bg-red-700 py-3 text-lg font-semibold text-white shadow-sm hover:bg-red-600 
                                focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
                        >
                            Agree & Join
                        </button>
                    </div>
                    {message && <p className="text-red-500 text-xs italic">{message}</p>}
                </form>
            </div>
            <p className="mt-10 text-center text-sm text-gray-500">
                By signing up you agree to our {' '}
                <a href="#" className="font-semibold leading-6 text-blue-500 hover:text-indigo-500">
                    Terms of Service
                </a>
                {' '} and {' '}
                <a href="#" className="font-semibold leading-6 text-blue-500 hover:text-indigo-500">
                    Privacy Policy
                </a>
            </p>
        </div>
    );
}

export default Signup;
