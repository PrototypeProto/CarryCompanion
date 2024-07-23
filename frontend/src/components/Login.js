import React, { useState } from 'react';

function Login()
{
    var loginName;
    var loginPassword;
    const [message,setMessage] = useState('');

    const app_name = 'carry-companion-02c287317f3a'
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

    const doLogin = async event =>
    {
        event.preventDefault();
        var obj = {username:loginName.value,password:loginPassword.value};
        var js = JSON.stringify(obj);
        
        try 
        {
            const response = await fetch(buildPath('api/login'), {
                method: 'POST',
                body: js,
                headers: { 'Content-Type': 'application/json' },
            });

    
            const res = await response.json();

            if (!response.ok) {
                // Check if the response status code is not OK (i.e., not 200)
                const errorData = await response.json();
                setMessage(errorData.message || 'User/Password combination incorrect');
                return;
            }

            localStorage.setItem('jwtToken', res.token);
 

            if (res && res.user && res.user.id) {
                var user = {
                    firstName: res.user.firstName,
                    lastName: res.user.lastName,
                    id: res.user.id,
                };
                localStorage.setItem('user_data', JSON.stringify(user));
                setMessage('');
                window.location.href = '/Home';
            } else {
                setMessage('User/Password combination incorrect');
            }
        } catch (e) {
            console.error('Error during login:', e);
            setMessage('An error occurred during login.');
        }
    };

    const handleForgotPassword = async (event) => 
    {
        event.preventDefault();
        const email = prompt('Please enter your email address:');
        if (!email) return;

        try {
            // const response = await fetch(buildPath('api/request-password-reset'), {
            const response = await fetch(buildPath('api/request-forgot-password'), {
                method: 'POST',
                body: JSON.stringify({ email }),
                headers: { 'Content-Type': 'application/json' },
            });

            const res = await response.json();

            if (response.ok) {
                alert('Password reset email sent. Please check your inbox.');
            } else {
                setMessage(res.message || 'An error occurred while trying to reset the password.');
            }
        } catch (error) {
            console.error('Error during password reset request:', error);
            setMessage('An error occurred while trying to reset the password.');
        }
    };

    return(
        // <div className="border border-solid border-indigo-600 flex flex-1 flex-col justify-center px-6 py-12 lg:px-8">
        <div className="bg-white-800 border-0 border-solid border-red-800 justify-items-center">
            <div className="bg-white shadow-2xl h-[504px] w-[352px] border border-solid rounded mt-20 mx-auto px-5">
                <form className="space-y-6" action="#" method="POST" onSubmit={doLogin}>
                    
                    <h2 className="mt-10 mb-12 text-center text-4xl font-semibold leading-9 tracking-tight text-gray-900">
                        Sign in
                    </h2>
                   
                    <div className="border-solid border-indigo-600">
                        <label htmlFor="email" className="block text-md font-medium leading-6 text-gray-900">
                            Email or username 
                        </label>
                        <div className="mt-2">
                            <input
                            id="email"
                            name="email"
                            placeholder="Email or Username"
                            // type="email"
                            type="text"
                            autoComplete="email"
                            required
                            className="block w-full rounded-md border-0 py-3
                             text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-md sm:leading-6"
                            ref={(c) => loginName = c}
                            />
                        </div>
                    </div>

                    <div className="border-solid border-indigo-600">
                        <div className="flex items-center justify-between">
                            <label htmlFor="password" className="block text-md font-medium leading-6 text-gray-900">
                            Password
                            </label>
                            <div className="text-sm">
                                <a href="#" className="font-semibold text-blue-500 hover:text-indigo-500" onClick={handleForgotPassword}>
                                    Forgot password?
                                </a>
                            </div>
                        </div>
                        <div className="mt-2">
                            <input
                            id="password"
                            name="password"
                            placeholder="Password"
                            type="password"
                            autoComplete="current-password"
                            required
                            className="block w-full rounded-md border-0 py-3 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300
                             placeholder:text-gray-400 placeholder:text-lg focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                            ref={(c) => loginPassword = c} // not sure if this is the best practice to get reference
                            />
                        </div>
                    </div>

                    <div className="border-solid border-indigo-600 py-6">
                        <button
                            type="submit"
                            className=" 
                            flex w-full justify-center rounded-md bg-red-700 py-3 text-lg font-semibold text-white shadow-sm hover:bg-red-600 
                            focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2"
                            // onClick={doLogin}
                        >
                            Sign in
                        </button>
                    </div>
                </form>

            </div>

            {/* Find a way to  make the link go to the signup page*/}
            <p className="border-solid border-indigo-600 mt-10 text-center text-md text-black">
                Don't have an account?{' '}
                <a href="/Signup" className="font-semibold leading-6 text-blue-500 hover:text-indigo-500">  
                Sign Up
                </a>
            </p>
        </div>
        
    )
};

export default Login;