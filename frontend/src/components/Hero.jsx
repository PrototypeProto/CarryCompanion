import React from 'react'
import Footer from './Footer'
import Header from './Header'

const Hero = () => {
    return (
        <div className="w-full h-screen">
            <img className='top-0 left-0 w-full h-screen object-cover'/>
            <div className= 'bg-gray-50'/>
                <div className='absolute top-0 w-full h-full flex flex-col justify-top text-red-700'>
                    <div className='md:left-[10%] max-w-[1100px] m-auto absolute p-4'>
                        <p>About Us!</p>
                        <h1 className=' font-bold text 5xl md: text-7xl drop-shadow-2xl'>We are a team of professionals</h1>
                        <p className='max-w-[600px] drop-shadow-2xl py-2 text-xl'>
                            This is for our COP4331 class! We are a team of college students who are passionate about coding and creating new things. We are excited to work on this project and see where it goes!
                        </p>
                        <br /><br /><br />

                    {/* About Us */}
                    <div class="2xl:container 2xl:mx-auto lg:py-16 lg:px-20 md:py-12 md:px-6 py-9 px-4 rounded-md bg-red-700">
                        <div class="flex flex-col lg:flex-row justify-between gap-8 ">
                            <div class="w-full lg:w-full flex flex-col justify-center rounded-md bg-[#ffffff19]">
                                <h1 class="text-3xl lg:text-4xl font-bold leading-9 text-gray-800 dark:text-white p-4">About Us</h1>
                                <p class="font-normal text-base leading-6 text-gray-600 dark:text-white p-4">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.In the first place we have granted to God, and by this our present charter confirmed for us and our heirs forever that the English Church shall be free, and shall have her rights entire, and her liberties inviolate; and we will that it be thus observed; which is apparent from</p>
                            </div>
                            <div class="w-full lg:w-8/12">
                                <img class="w-full h-full" src="https://i.ibb.co/FhgPJt8/Rectangle-116.png" alt="A group of People" />
                            </div>
                        </div>
                    
                    <br />
                    
                
                    {/* Our Story */}
                    <div class="flex lg:flex-row flex-col justify-between gap-8 pt-12 rounded-md bg-[#ffffff19]">
                        <div class="w-full lg:w-5/12 flex flex-col justify-center">
                            <h1 class="text-3xl lg:text-4xl font-bold leading-9 text-gray-800 dark:text-white p-4">Our Story</h1>
                            <p class="font-normal text-base leading-6 text-gray-600 dark:text-white p-4">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum.In the first place we have granted to God, and by this our present charter confirmed for us and our heirs forever that the English Church shall be free, and shall have her rights entire, and her liberties inviolate; and we will that it be thus observed; which is apparent from</p>
                        </div>

                    {/* Photos */}
                    <div class="w-full lg:w-8/12 lg:pt-8">
                        <div class="grid md:grid-cols-4 sm:grid-cols-2 grid-cols-1 lg:gap-4 rounded-md">
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/image0.jpg" alt="ASH" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Ash</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="" alt="Olivia featured Image" />
                                <img class="md:hidden block" src="https://i.ibb.co/NrWKJ1M/Rectangle-119.png" alt="Olivia featured Image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Ben</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/image0.jpg" alt="Liam featued Image" />
                                <img class="md:hidden block" src="https://i.ibb.co/C5MMBcs/Rectangle-120.png" alt="Liam featued Image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Gabriel</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/20220804_115419.png" alt="Elijah featured image" />
                                <img class="md:hidden block" src="https://i.ibb.co/ThZBWxH/Rectangle-121.png" alt="Elijah featured image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Josh</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/IMG_8444.jpg" alt="Elijah featured image" />
                                <img class="md:hidden block" src="https://i.ibb.co/ThZBWxH/Rectangle-121.png" alt="Elijah featured image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Josh</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/20240603_195222.jpg" alt="Elijah featured image" />
                                <img class="md:hidden block" src="https://i.ibb.co/ThZBWxH/Rectangle-121.png" alt="Elijah featured image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Geno</p>
                            </div>
                            <div class="p-4 pb-6 flex justify-center flex-col items-center">
                                <img class="md:block hidden" src="/Images/IMG_5439.jpg" alt="Elijah featured image" />
                                <img class="md:hidden block" src="https://i.ibb.co/ThZBWxH/Rectangle-121.png" alt="Elijah featured image" />
                                <p class="font-medium text-xl leading-5 text-gray-800 dark:text-white mt-4">Alejandro</p>
                            </div>
                        </div>
                    </div>
                </div>
        </div>
        <br /><br /><br />
                </div>
            </div>
            <Footer />
        </div>
    )
  }


  export default Hero;