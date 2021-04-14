import React from 'react'
import { Text } from 'react-native'
import styled from 'styled-components/native'
import globalStyles from '../../extra/styles/global'

import {AppScreens} from '../../navigation/DrawerNavigator'


const Collectibles = ({navigation}) => {
    return (
        <SafeArea>
            <Container>
                
            </Container>
        </SafeArea>
    )
}

export default Collectibles;


/* Styles */
const SafeArea = styled.SafeAreaView`
    flex: 1;
`;

const Container = styled.View`
    flex: 1;
    justify-content: flex-end;
    padding: 0 32px 32px 32px;
`;