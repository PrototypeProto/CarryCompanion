const Footer = () => {
  return (
    <footer className="bg-gray-900 text-white">
      <div className="md:flex md:justify-between md:items-center sm:px-12 px-full bg-[#ffffff19] py-3">
      </div>
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-10 text-center pt-2 text-gray-400 text-sm pb-8">
        <span>© 2024 Appy. All rights reserved.</span>
        <a href="#" className="font-medium text-red-600 dark:text-red-500 underline">View Disclaimer</a>
        <span>Terms · Privacy Policy</span>
        <div className="flex flex-col items-center gap-2 ">
          <h1 className="underline">Contact us</h1>
          <span>Phone: (123) 456-7890</span>
          <span>Email: contact@appy.com</span>
        </div>
      </div>
    </footer>
  );
};

export default Footer;
