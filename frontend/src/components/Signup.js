import React, { useState } from 'react';
import { validatePassword } from './passwordValidation';


// Add "Already have an account? Log in" at the top of the form below Sign up

function Signup()
{
    var username;
    // Probably shouldn't require these two.
    var firstName = "John"; 
    var lastName = "Doe";
    var signupEmail;
    var signupPassword;
    const [message,setMessage] = useState('');
    const [passwordError, setPasswordError] = useState('');
    const [passwordRules, setPasswordRules] = useState({
        length: false,
        uppercase: false,
        lowercase: false,
        digit: false,
        special: false,
    });

    // const app_name = 'carry-companion-02c287317f3a'
    function buildPath(route)
    {
        if (process.env.NODE_ENV === 'production')
        {
            // return 'https://' + app_name + '.herokuapp.com/' + route;
            return 'https://www.thisisforourclass.xyz/' + route;
        }
        else
        {
            return 'http://localhost:5000/' + route;
        }
    }

    // Define password complexity rule
    const passwordComplexity = (password) => {
        const regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        return regex.test(password);
    }

    const doSignup = async event =>
    {
        event.preventDefault();

        const password = signupPassword.value;

        // if (!passwordComplexity(password)) {
        //     setPasswordError('Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, one digit, and one special character.');
        //     return;
        // }

        if (!Object.values(passwordRules).every(rule => rule)) {
            setPasswordError('Password must meet all the requirements.');
            return;
        }

        // var obj = {signup:username.value,password:signupPassword.value};
        var obj = {username:username.value, password:signupPassword.value, firstName:firstName, lastName:lastName, email:signupEmail.value};
        var js = JSON.stringify(obj);
        
        try
        {
            // Probably needs to be /api/signup
            const response = await fetch(buildPath("api/signup"), 
                {method:'POST',body:js,headers:{'Content-Type':'application/json'}});
        
            var res = JSON.parse(await response.text());

            if( res.id <= 0 )
            {
                setMessage('User/Password combination incorrect');
            }
            else
            {
                var user =
                {firstName:res.firstName,lastName:res.lastName,id:res.id}
                localStorage.setItem('user_data', JSON.stringify(user));
                setMessage('');
                // window.location.href = '/Home';
                window.location.href = '/EmailSent';
            }
        }
        catch(e)
        {
            // alert(e.toString());
            // return;
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

            <div className="bg-white shadow-2xl h-[550px] w-[352px] border border-solid rounded mt-20 mx-auto px-5">
                <form className="space-y-6 border-0 border-solid border-indigo-600" action="#" method="POST" onSubmit={doSignup}>
                    
                    <div className="border-0 border-solid  border-indigo-600 sm:mx-auto sm:w-full sm:max-w-sm">
                        {/* <h2 className="mt-10 text-center text-2xl font-bold leading-9 tracking-tight text-gray-900"> */}
                        <h2 className="mt-9 mb-8 text-center text-4xl font-semibold leading-9 tracking-tight text-gray-900">
                            Create your account
                        </h2>
                    </div>
                    
                    <div>
                        {/* htmlFor indicates the form element that this label describes */}
                        <label htmlFor="username" className="block text-md font-medium leading-6 text-gray-900"> 
                            Username
                        </label>
                        <div className="mt-2">
                            <input
                            id="username"
                            name="username"
                            // type="email"
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
                        <label htmlFor="email" className="block text-md font-medium leading-6 text-gray-900">
                            Email address
                        </label>
                        <div className="mt-2">
                            <input
                            id="email"
                            name="email"
                            // type="email"
                            type="text"
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
                            autoComplete="current-password"
                            required
                            className="block w-full rounded-md border-0 py-3
                            text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                            // className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                            ref={(c) => signupPassword = c} // not sure if this is the best practice to get reference
                            onChange={handlePasswordChange}
                            />
                        </div>
                        {/* Passowrd complexity */}
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
                            // className="flex w-full justify-center rounded-md bg-red-700 px-3 py-1.5 text-sm font-semibold leading-6 text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
                            // onClick={doLogin}
                            className="flex w-full justify-center rounded-md bg-red-700 py-3 text-lg font-semibold text-white shadow-sm hover:bg-red-600 
                            focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
                        >
                            Agree & Join
                        </button>
                    </div>
                </form>
            </div>

            {/* Find a way to make the link go to the signup page*/}
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
        
    )
};

export default Signup;