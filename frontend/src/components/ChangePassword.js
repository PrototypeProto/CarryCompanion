import React, { useState } from "react";

const ChangePassword = () => {
    const [password, setPassword] = useState("");
    const [confirmPassword, setConfirmPassword] = useState("");
    const [error, setError] = useState("");
    const [success, setSuccess] = useState("");
    const [token, setToken] = useState("");

    // Get the token from the URL query parameters
    React.useEffect(() => {
        const queryParams = new URLSearchParams(window.location.search);
        const token = queryParams.get("token");
        setToken(token);
    }, []);

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (password !== confirmPassword) {
            setError("Passwords do not match");
            return;
        }

        const payload = { token, newPassword: password };

        try {
            const response = await fetch("https://www.thisisforourclass.xyz/api/forgot-password", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(payload),
            });

            const data = await response.json();

            if (!response.ok) {
                setError(data.message || "An error occurred");
            } else {
                setSuccess("Password reset successful");
                setError("");
                setPassword("");
                setConfirmPassword("");
            }
        } catch (error) {
            setError("An error occurred. Please try again.");
        }
    };

    return (
        <div className="w-full h-screen">
            <div className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden py-6 sm:py-12 bg-gray-100">
                <div className="flex flex-col px-10 py-28 text-center shadow-lg rounded-md bg-white">
                    <h1 className="mb-2 text-[42px] font-bold text-zinc-800">
                        Reset Your <span className="text-red-600">Password</span>
                    </h1>
                    <br />
                    <br />
                    {error && <div className="text-red-600">{error}</div>}
                    {success && <div className="text-green-600">{success}</div>}
                    <form className="flex flex-col px-8 gap-4 font-bold text-red-600" onSubmit={handleSubmit}>
                        <input
                            type="password"
                            placeholder="Password"
                            className="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
                            value={password}
                            onChange={(e) => setPassword(e.target.value)}
                            required
                        />
                        <input
                            type="password"
                            placeholder="Confirm Password"
                            className="w-96 px-5 py-3 rounded-md border border-gray-300 focus:outline-none focus:ring-2 focus:ring-red-600"
                            value={confirmPassword}
                            onChange={(e) => setConfirmPassword(e.target.value)}
                            required
                        />
                        <button
                            type="submit"
                            className="w-1/3 h-14 px-5 py-1 rounded-md bg-red-600 text-white font-medium shadow-md shadow-indigo-500/20 hover:bg-red-700"
                        >
                            Enter
                        </button>
                    </form>
                </div>
            </div>
        </div>
    );
};

export default ChangePassword;
