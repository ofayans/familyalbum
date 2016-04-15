"""empty message

Revision ID: a43aeb3ad0bf
Revises: ccaeddbd4688
Create Date: 2016-04-15 07:37:57.364201

"""

# revision identifiers, used by Alembic.
revision = 'a43aeb3ad0bf'
down_revision = 'ccaeddbd4688'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('users', sa.Column('photos_uploaded', sa.Integer(), nullable=True))
    op.add_column('users', sa.Column('tarif', sa.Unicode(), nullable=True))
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('users', 'tarif')
    op.drop_column('users', 'photos_uploaded')
    ### end Alembic commands ###
