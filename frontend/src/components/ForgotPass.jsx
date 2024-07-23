import React, { useState } from "react";
import Footer from './Footer';

const ForgotPass = () => {
    const [email, setEmail] = useState("");
    const [message, setMessage] = useState("");

    // const app_name = 'carry-companion-02c287317f3a';
    function buildPath(route) {
      if (process.env.NODE_ENV === 'production') {
          // return 'https://' + app_name + '.herokuapp.com/' + route;
          return 'https://www.thisisforourclass.xyz/' + route;
      } else {
          return 'http://localhost:5000/' + route;
      }
  }
    const handleSubmit = async (event) => {
        event.preventDefault();

        try {
            const response = await fetch(buildPath('api/request-forgot-password'), {
                method: 'POST',
                body: JSON.stringify({ email }),
                headers: { 'Content-Type': 'application/json' },
            });

            const res = await response.json();

            if (response.ok) {
                setMessage('Password reset email sent. Please check your inbox.');
            } else {
                setMessage(res.message || 'An error occurred while trying to reset the password.');
            }
        } catch (error) {
            console.error('Error during password reset request:', error);
            setMessage('An error occurred while trying to reset the password.');
        }
    };

    return (
        <div className="w-full h-screen">
            <div className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
                <div className="flex flex-col px-10 py-28 text-center shadow-lg rounded-md bg-white">
                    <h1 className="mb-2 text-[42px] font-bold text-zinc-800">
                        Forgot Your <span className="text-red-600">Password</span>?
                    </h1>
                    <br /><br />
                    <form onSubmit={handleSubmit} className="flex flex-col px-8 gap-4 font-bold text-red-600">
                        <input
                            type="email"
                            placeholder="Email"
                            className="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
                            value={email}
                            onChange={(e) => setEmail(e.target.value)}
                            required
                        />
                        <button
                            type="submit"
                            className="w-1/3 h-14 px-5 py-1 rounded-md bg-red-600 text-white font-medium shadow-md shadow-indigo-500/20 hover:bg-red-700"
                        >
                            Enter
                        </button>
                    </form>
                    {message && <p className="mt-4 text-green-500">{message}</p>}
                </div>
            </div>
            <Footer />
        </div>
    );
};

export default ForgotPass;
