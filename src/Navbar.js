import React from 'react';

import { Nav, NavLink,  NavMenu, NavBtn, NavBtnLink } from './NavbarElements';

const Navbar = () => {
    return (
        <>
            <Nav>

                {/* <Bars /> */}

                <NavMenu>

                    <NavLink to='/' activeStyle>

                        Home

                    </NavLink>



                    <NavLink to='/info' activeStyle>

                        Info
                    </NavLink>
                </NavMenu>

                {/* <NavBtn>

                    <NavBtnLink to='/signin'>Sign In</NavBtnLink>

                </NavBtn> */}

            </Nav>

        </>

    );

};

export default Navbar;